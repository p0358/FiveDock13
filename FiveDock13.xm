@interface SBIconListGridLayoutConfiguration
  @property (assign,nonatomic) unsigned long long numberOfPortraitColumns;                                        //@synthesize numberOfPortraitColumns=_numberOfPortraitColumns - In the implementation block
  @property (assign,nonatomic) unsigned long long numberOfPortraitRows;                                           //@synthesize numberOfPortraitRows=_numberOfPortraitRows - In the implementation block
  @property (assign,nonatomic) unsigned long long numberOfLandscapeColumns;                                       //@synthesize numberOfLandscapeColumns=_numberOfLandscapeColumns - In the implementation block
  @property (assign,nonatomic) unsigned long long numberOfLandscapeRows;
@end

@interface SBDockIconListView
-(BOOL)isVertical;
@end

typedef struct SBIconCoordinate {
    NSInteger row;
    NSInteger col;
} SBIconCoordinate;

%hook SBIconListGridLayoutConfiguration

  -(unsigned long long)numberOfPortraitColumns
  {
    // NSString *msg = [NSString stringWithFormat:@"Number of portrait Rows -> %lld",self.numberOfPortraitRows];
    // UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"USBRespring" message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    // [alertView show];
    // [alertView release];

    if (self.numberOfPortraitRows == 1)
      return 5;

    return %orig;
  }

  -(void)setNumberOfPortraitColumns:(unsigned long long)arg1
  {
    if (self.numberOfPortraitRows == 1)
      arg1 = 5;

    %orig;
  }

  -(unsigned long long)numberOfLandscapeColumns
  {
    if (self.numberOfLandscapeRows == 1)
      return 5;

    return %orig;
  }

  -(void)setNumberOfLandscapeColumns:(unsigned long long)arg1
  {
    if (self.numberOfLandscapeRows == 1)
      arg1 = 5;

    %orig;
  }

%end

%hook SBDockIconListView
-(CGPoint)originForIconAtCoordinate:(struct SBIconCoordinate)arg1 numberOfIcons:(unsigned long long)arg2 {
    if (arg2 == 5) {

        bool isPortrait = ![self isVertical];

        struct SBIconCoordinate cor1;
        cor1.row = isPortrait ? 1 : 1;
        cor1.col = isPortrait ? 1 : 1;

        struct SBIconCoordinate cor2;
        cor2.row = isPortrait ? 1 : 2;
        cor2.col = isPortrait ? 2 : 1;

        struct SBIconCoordinate cor3;
        cor3.row = isPortrait ? 1 : 3;
        cor3.col = isPortrait ? 3 : 1;

        struct SBIconCoordinate cor4;
        cor4.row = isPortrait ? 1 : 4;
        cor4.col = isPortrait ? 4 : 1;

        CGPoint originalPointForIcon1 = %orig(cor1, 4);
        CGPoint originalPointForIcon2 = %orig(cor2, 4);
        CGPoint originalPointForIcon3 = %orig(cor3, 4);
        CGPoint originalPointForIcon4 = %orig(cor4, 4);

        if (isPortrait) {

            // Portrait
            int defaultY = originalPointForIcon1.y;

            int newIcon1X = originalPointForIcon1.x - (int)(originalPointForIcon1.x * 0.21);
            int newIcon2X = originalPointForIcon2.x - (int)(originalPointForIcon2.x * 0.21);
            int newIcon3X = originalPointForIcon3.x - (int)(originalPointForIcon3.x * 0.21);
            int newIcon4X = originalPointForIcon4.x - (int)(originalPointForIcon4.x * 0.21);
            int newIcon5X = originalPointForIcon4.x + (int)(originalPointForIcon4.x * 0.03);

            if (arg1.col == 1) {
                return CGPointMake(newIcon1X, defaultY);
            }
            else if (arg1.col == 2) {
                return CGPointMake(newIcon2X, defaultY);
            }
            else if (arg1.col == 3) {
                return CGPointMake(newIcon3X, defaultY);
            }
            else if (arg1.col == 4) {
                return CGPointMake(newIcon4X, defaultY);
            }
            else {
                return CGPointMake(newIcon5X, defaultY);
            }
        
        } else {

            // Landscape
            int defaultX = originalPointForIcon1.x;

            int newIcon1Y = originalPointForIcon1.y - (int)(originalPointForIcon1.y * 0.21);
            int newIcon2Y = originalPointForIcon2.y - (int)(originalPointForIcon2.y * 0.21);
            int newIcon3Y = originalPointForIcon3.y - (int)(originalPointForIcon3.y * 0.21);
            int newIcon4Y = originalPointForIcon4.y - (int)(originalPointForIcon4.y * 0.21);
            int newIcon5Y = originalPointForIcon4.y + (int)(originalPointForIcon4.y * 0.03);

            if (arg1.row == 1) {
                return CGPointMake(defaultX, newIcon1Y);
            }
            else if (arg1.row == 2) {
                return CGPointMake(defaultX, newIcon2Y);
            }
            else if (arg1.row == 3) {
                return CGPointMake(defaultX, newIcon3Y);
            }
            else if (arg1.row == 4) {
                return CGPointMake(defaultX, newIcon4Y);
            }
            else {
                return CGPointMake(defaultX, newIcon5Y);
            }

        }
    }
    return %orig;

}
%end
