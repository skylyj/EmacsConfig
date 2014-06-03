#!/usr/bin/env ruby
confs=%W[basic alias org package ibuffer ido auctex tramp smex auto-complete expand_region dired tabbar desktop better-registers magit eshell python rinari yasnippet ruby sr-speedbar view projectile]

conf_fnms=confs.map{|i| "./Config/"+i+"_conf.el"}
func_fnms=%W[coll_func my_func].map{|i| "./Config/"+i+".el"}
all_fnms=conf_fnms+func_fnms
pwd=File.expand_path(File.dirname(__FILE__))
File.open(File.expand_path("~/.emacs"),"w"){|ofp|
    ofp.puts(";;BEGIN load path")
    confs.each{|fnm|
        dirnm=File.join(pwd,"Extensions",fnm)
        if File.directory? dirnm
            str= %Q[(add-to-list 'load-path "#{dirnm}")] 
            puts dirnm
            ofp.puts str
        end
    }
    ofp.puts(";;END load path")
    ofp.puts
    all_fnms.each{|fnm|
        ofp.puts(";;BEGIN #{fnm}")
        File.foreach(fnm){|line|
            ofp.puts line
        }
        ofp.puts(";;END #{fnm}")
        ofp.puts
    }
}
    
