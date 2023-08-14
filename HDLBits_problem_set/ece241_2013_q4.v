// A large reservoir of water serves users. In order to keep the level of water sufficiently high, three sensors are placed vertically at 5-inch intervals. When the water is above teh highest sensor (S_3), the input flow rate should be zero. When teh level is below the lowest sensor (s_1), the flow rate should be at maximum (both Nominal flow valve and Supplemental flow valve opened). The flow rate when teh level is between the upper and lower sensors is determined by two factors: the water level and the level previous to the last sensor change. Each water level has a nominal flow rate associated with it, as shown in the table below. If teh sensor change indicates that the previous level was ower than the current level, the nominal flow rate should take place. If the previous level was higher than the current level, the flow rate should be increased by opening the Supplemental flow valve (controlled by delta FR). Design a moore model for the water reservoir controller. Clearly indicate all state transition and output for each satte. The inputs to your FSM are S_1, S_2 and S_3; the outputs are FR1, FR2, FR3, adn delta FR.

//	Water Level 		Sensor Assorted		Nominal FLow Rate Inputs to Be Asserted
//	Above S_3				S_1,S_2,S_3				None
//	Between S_3 and S_2		S_1,S_2					FR1
//	Between S_2 and S_1		S_1						FR1,FR2
// 	Below S_1				None					FR1,FR2,FR3

// Also include an active-high synchronous reset that resets the state machine to a state equivalent to if the water level had been low for a long time (no sensors asserted, and all four outputs asserted).

module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 

	// Insert your code here

endmodule
