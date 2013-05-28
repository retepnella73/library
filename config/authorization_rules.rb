authorization do
  
  role :guest do
    has_permission_on :books, :to => [:index, :show]
    has_permission_on :authors, :to => [:index, :show]
    has_permission_on :publishers, :to => [:index, :show]
    has_permission_on :discs, :to => [:index, :show]
    has_permission_on :tracks, :to => [:index, :show]
    has_permission_on :artists, :to => [:index, :show]
    has_permission_on :labels, :to => [:index, :show]
    has_permission_on :genres, :to => [:index, :show]
    has_permission_on :disc_formats, :to => [:index, :show]
  end
  
  role :user do
    includes :guest
    has_permission_on :books, :to => [:edit, :update]
    has_permission_on :authors, :to => [:edit, :update]
    has_permission_on :publishers, :to => [:edit, :update]
    has_permission_on :discs, :to => [:edit, :update]
    has_permission_on :tracks, :to => [:edit, :update]
    has_permission_on :artists, :to => [:edit, :update]
    has_permission_on :labels, :to => [:edit, :update]
    has_permission_on :genres, :to => [:edit, :update]
    has_permission_on :disc_formats, :to => [:edit, :update]
  end
  
  role :admin do
    includes :user
    has_permission_on :books, :to => [:new, :create, :destroy]
    has_permission_on :authors, :to => [:new, :create, :destroy]
    has_permission_on :publishers, :to => [:new, :create, :destroy]
    has_permission_on :discs, :to => [:new, :create, :destroy]
    has_permission_on :tracks, :to => [:new, :create, :destroy]
    has_permission_on :artists, :to => [:new, :create, :destroy]
    has_permission_on :labels, :to => [:new, :create, :destroy]
    has_permission_on :genres, :to => [:new, :create, :destroy]
    has_permission_on :disc_formats, :to => [:new, :create, :destroy]
    has_permission_on :authorization_rules, :to => [:read]
    has_permission_on :authorization_usages, :to => [:read]
  end
  
end
