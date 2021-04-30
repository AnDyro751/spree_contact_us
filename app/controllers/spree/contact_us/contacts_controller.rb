class Spree::ContactUs::ContactsController < Spree::StoreController
  helper 'spree/products'
  def create
    @contact = Spree::ContactUs::Contact.new(params[:contact_us_contact])
    respond_to do |format|
      if @contact.save
        if Spree::ContactUs::Config.contact_tracking_message.present?
          flash[:contact_tracking] = Spree::ContactUs::Config.contact_tracking_message
        end
        format.html { redirect_to(spree.root_path, notice: Spree.t('spree_contact_us.notices.success')) }
        format.json { render json: { success: true, error: nil }, status: :created}
      else
        format.html { render :new }
        format.json { render json: { success: false, error: "Invalid request", status: :unprocessable_entity } }
      end
    end
  end

  def new
    @contact = Spree::ContactUs::Contact.new
    @taxonomies = Spree::Taxonomy.includes(root: :children)
  end

  def meta_data_tags; end
  helper_method :meta_data_tags

  private

  def accurate_title
    Spree.t(:contact_us_title)
  end
end
