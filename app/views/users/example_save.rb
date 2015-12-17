# EDIT USER
<%= form_for(@user) do |f| %>
    <% if @user.errors.any? %>
        <div id="error_explanation">
            <h2><%= pluralize(@user.errors.count, "error") %> prohibited this User from being saved:</h2>
            <ul>
                <% @user.errors.full_messages.each do |message| %>
                    <li><%= message %></li>
                <% end %>
            </ul>
        </div>
    <% end %>
    
    <%= f.label :email %>
    <%= f.email_field :email, class: 'form-control' %>

    <%= f.label :nickname %>
    <%= f.text_field :nick_name, class: 'form-control' %>

    <%= f.label :new_password %>
    <%= f.password_field :password, class: 'form-control', placeholder: "Enter Password Confirmation" %>

    <%= f.label :password_confirmation, "New Confirmation Password" %>
    <%= f.password_field :password_confirmation, class: 'form-control', placeholder: "Enter New Password Confirmation"%>
	
	<%= f.label :current_password %>
    <%= f.password_field :current_password, class: 'form-control', placeholder: "Enter Current Password"%>

    <%= f.submit "Update Account", class: "btn btn-primary" %>
<% end %>

#*************************************************************************************
