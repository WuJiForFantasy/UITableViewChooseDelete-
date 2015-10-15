//
//  FileItemTableCell.h
//  SiteVistor
//
//  Created by HJC on 10-12-9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileItemTableCell : UITableViewCell
{
@private
	UIImageView*	m_checkImageView;
	BOOL			m_checked;
}

- (void) setChecked:(BOOL)checked;

@end
