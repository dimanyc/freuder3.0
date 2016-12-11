import dashboardReducer from './dashboardReducer'
import { $$initialState as $$dashboardState } from './dashboardReducer'

export default {
  $$dashboardStore: dashboardReducer
}

export const initialStates = {
  $$dashboardState
}

