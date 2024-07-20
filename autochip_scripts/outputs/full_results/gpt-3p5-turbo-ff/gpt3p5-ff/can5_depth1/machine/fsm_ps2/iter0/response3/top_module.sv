module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

// define states
parameter BYTE1 = 2'b00;
parameter BYTE2 = 2'b01;
parameter BYTE3 = 2'b10;
parameter DONE = 2'b11;
    
reg [1:0] state;     // state register

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= BYTE1;    // reset to starting state
    else begin
        case (state)
            BYTE1: begin
                if (in[2] == 1)
                    state <= BYTE2;    // transition to BYTE2
                else
                    state <= BYTE1;    // remain in BYTE1
            end
            BYTE2: begin
                state <= BYTE3;    // transition to BYTE3
            end
            BYTE3: begin
                state <= DONE;    // transition to DONE
            end
            DONE: begin
                if (in[2] == 1)
                    state <= BYTE2;    // transition back to BYTE2
                else
                    state <= BYTE1;    // transition back to BYTE1
            end
        endcase
    end
end

assign done = (state == DONE);    // assert done signal in DONE state

endmodule
