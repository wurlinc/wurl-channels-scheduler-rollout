declare module 'material-ui';
import { DocumentNode } from 'graphql'

declare module "*.graphql" {
  const value: DocumentNode; // or you can say any
  export default value;
}
