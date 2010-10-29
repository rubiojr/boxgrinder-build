#
# Copyright 2010 Red Hat, Inc.
#
# This is free software; you can redistribute it and/or modify it
# under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation; either version 3 of
# the License, or (at your option) any later version.
#
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this software; if not, write to the Free
# Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
# 02110-1301 USA, or see the FSF site: http://www.fsf.org.

require 'boxgrinder-build/managers/plugin-manager'

module BoxGrinder
  describe PluginManager do

    before(:each) do
      @manager = PluginManager.instance
    end

    it "should register simple plugin" do
      @manager.register_plugin( { :class => PluginManager, :type => :delivery, :name => :abc, :full_name  => "Amazon Simple Storage Service (Amazon S3)" } )

      @manager.plugins[:delivery].size.should == 1
      @manager.plugins[:delivery][:abc][:class].should == PluginManager
    end

    it "should register plugin with many types" do
      @manager.register_plugin( { :class => PluginManager, :type => :delivery, :name => :s3, :full_name  => "Amazon Simple Storage Service (Amazon S3)", :types => [:s3, :cloudfront, :ami] } )

      @manager.plugins[:delivery].size.should == 4
      @manager.plugins[:delivery][:abc][:class].should == PluginManager
      @manager.plugins[:delivery][:ami][:class].should == PluginManager
      @manager.plugins[:delivery][:s3][:class].should == PluginManager
      @manager.plugins[:delivery][:cloudfront][:class].should == PluginManager
    end
  end
end
