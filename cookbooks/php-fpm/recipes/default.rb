%w{ php53u php53u-mysql php53u-mbstring php53u-mcrypt php53u-bcmath php53u-fpm php53u-devel php53u-pecl-redis php53u-pecl-lzf php53u-pecl-memcache php53u-gd gd gd-devel php53u-cli php53u-xml php53u-soap php53u-pecl-apc }.each do |pkg|
	package(pkg)
end
