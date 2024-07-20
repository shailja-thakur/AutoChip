module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    reg [2:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b001; // start in BYTE1 state
        end else begin
            case (state)
                3'b001: begin // BYTE1 state
                    if (in[2] == 1'b1) begin
                        state <= 3'b010; // transition to BYTE2 state
                    end
                end
                3'b010: begin // BYTE2 state
                    state <= 3'b011; // transition to BYTE3 state
                end
                3'b011: begin // BYTE3 state
                    state <= 3'b100; // transition to DONE state
                end
                3'b100: begin // DONE state
                    if (in[2] == 1'b0) begin
                        state <= 3'b001; // transition back to BYTE1 state
                    end else begin
                        state <= 3'b010; // transition back to BYTE2 state
                    end
                end
            endcase
        end
    end
    
    assign done = (state == 3'b100);
    
endmodule
