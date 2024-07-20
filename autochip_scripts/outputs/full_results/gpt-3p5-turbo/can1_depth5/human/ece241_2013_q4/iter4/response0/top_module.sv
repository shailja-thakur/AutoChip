module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [3:1] state; // state variable to keep track of the water level
reg [3:1] last_state; // variable to keep track of previous state

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0; // initialize state to 0 when reset is high
        fr3 <= 1;   // set fr3 output to 1 during reset
        fr2 <= 1;   // set fr2 output to 1 during reset
        fr1 <= 1;   // set fr1 output to 1 during reset
        dfr <= 1;   // set dfr output to 1 during reset
    end else begin
        case (s)
            3'b111: begin // Water level above s[3]
                state <= s;
                fr3 <= 0; // fr3 output is 0 when water level is above s[3]
                fr2 <= 0; // fr2 output is 0 when water level is above s[3]
                fr1 <= 0; // fr1 output is 0 when water level is above s[3]
                dfr <= 1; // dfr output is 1 when water level is above s[3]
            end
            3'b110: begin // Water level between s[3] and s[2]
                state <= s;
                fr3 <= 0; // fr3 output is 0 when water level is between s[3] and s[2]
                fr2 <= 0; // fr2 output is 0 when water level is between s[3] and s[2]
                fr1 <= 1; // fr1 output is 1 when water level is between s[3] and s[2]
                dfr <= 1; // dfr output is 1 when water level is between s[3] and s[2]
            end
            3'b100: begin // Water level between s[2] and s[1]
                state <= s;
                fr3 <= 0; // fr3 output is 0 when water level is between s[2] and s[1]
                fr2 <= 1; // fr2 output is 1 when water level is between s[2] and s[1]
                fr1 <= 1; // fr1 output is 1 when water level is between s[2] and s[1]
                dfr <= 1; // dfr output is 1 when water level is between s[2] and s[1]
            end
            3'b000: begin // Water level below s[1]
                state <= s;
                fr3 <= 1; // fr3 output is 1 when water level is below s[1]
                fr2 <= 1; // fr2 output is 1 when water level is below s[1]
                fr1 <= 1; // fr1 output is 1 when water level is below s[1]
                dfr <= 0; // dfr output is 0 when water level is below s[1]
            end
            default: begin
                state <= 0; // default assignment
                fr3 <= 1; // default assignment
                fr2 <= 1; // default assignment
                fr1 <= 1; // default assignment
                dfr <= 1; // default assignment
            end
        endcase
        // Check if the previous state was lower than the current state
        if (state > last_state)
            dfr <= 0; // increase flow rate by closing Supplemental flow valve
        last_state <= state; // update last_state with the current state
    end
end

endmodule
