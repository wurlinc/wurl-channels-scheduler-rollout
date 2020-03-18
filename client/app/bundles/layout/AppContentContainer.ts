import { connect } from 'react-redux';
import AppContent, {AppContentProps} from './AppContent';
import { TGlobalState } from '../../types';

const mapStateToProps= (state:TGlobalState):Partial<AppContentProps> =>({
  rox_flag_ruby: state.rox_flag_ruby,
});

//@ts-ignore
export default connect(mapStateToProps)(AppContent);
