module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    reg [7:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b001; // BYTE1 state
        end else begin
            case (state)
                3'b001: begin // BYTE1 state
                    if (in[2]) begin
                        state <= 3'b010; // BYTE2 state
                    end
                end
                3'b010: begin // BYTE2 state
                    state <= 3'b011; // BYTE3 state
                end
                3'b011: begin // BYTE3 state
                    if (in[2]) begin
                        state <= 3'b100; // DONE state
                    end
                end
                3'b100: begin // DONE state
                    if (in[2]) begin
                        state <= 3'b010; // BYTE2 state
                    end else begin
                        state <= 3'b001; // BYTE1 state
                    end
                end
            endcase
        end
    end
    
    assign done = (state == 3'b100); // assert done signal when in DONE state
    
endmodule
