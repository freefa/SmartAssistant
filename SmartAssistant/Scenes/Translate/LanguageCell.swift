//
//  LanguageCell.swift
//  SmartAssistant
//
//  Created by Louis.B on 2019/12/13.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import UIKit

class LanguageCell: SelectCell<TLanguage> {
    
    override var model: TLanguage? {
        didSet {
            self.textLabel?.text = LANGUAGE_DISPLAY_MAP[model!]
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
