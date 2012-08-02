--Removing everything except for CMIS widget & Canonical page with it installed

delete from page_user;
delete from region_widget;
delete from region;
delete from page;
delete from page_template_widget;
delete from widget_category;
delete from widget_rating;
delete from widget_tag;
delete from widget;

-- CMIS Gadget
set @repository_browser = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @widget_seq);
insert into widget (entity_id, title, url, type, widget_status, description, author, owner_id)
values(@repository_browser, 'CMIS Repository Browser', 'http://localhost:8080/demogadgets/repo_browser/repo_browser.xml', 'OpenSocial', 'PUBLISHED', 'Browse a CMIS repository and download files.', 'Ryan J. Baxter', @user_id_1);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @widget_seq;

--- Layout for user_id_1 ---
set @cmis_page_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @page_seq);
INSERT INTO page (entity_id, name, owner_id, parent_page_id, page_layout_id, page_type)
values (@cmis_page_id, 'CMIS', @user_id_1, null, @newuser_col_id, 'USER');
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @page_seq;

--Set up page user data
set @cmis_page_user_id =(SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @page_user_seq);
insert into page_user (entity_id, page_id, user_id, editor, render_sequence, page_status)
values (@cmis_page_user_id, @cmis_page_id, @user_id_1, true, 1, 'OWNER');
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @page_user_seq;

--end page user data

set @cmis_page_1_region_1 = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @region_seq);
INSERT INTO region(entity_id, page_id, render_order, locked)
values (@cmis_page_1_region_1, @cmis_page_id, 1, false);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @region_seq;

set @cmis_page_1_region_2 = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @region_seq);
INSERT INTO region(entity_id, page_id, render_order, locked)
values (@cmis_page_1_region_2, @cmis_page_id, 2, false);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @region_seq;

set @cmis_page_1_region_3 = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @region_seq);
INSERT INTO region(entity_id, page_id, render_order, locked)
values (@cmis_page_1_region_3, @cmis_page_id, 3, false);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @region_seq;

set @next_region_widget = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @region_widget_seq);
INSERT INTO region_widget(entity_id, widget_id, region_id, render_order, collapsed, locked, hide_chrome)
values (@next_region_widget, @repository_browser, @cmis_page_1_region_1, 0, FALSE, FALSE, FALSE);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @region_widget_seq;