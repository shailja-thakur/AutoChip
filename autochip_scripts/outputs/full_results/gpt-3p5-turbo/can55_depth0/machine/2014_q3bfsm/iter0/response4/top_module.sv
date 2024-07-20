module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000;
        else begin
            case (state)
                3'b000: begin // state A
                    if (x)
                        state <= 3'b001; // transition to state B
                    else
                        state <= 3'b000; // remain in state A
                end
                
                3'b001: begin // state B
                    if (x)
                        state <= 3'b100; // transition to state E
                    else
                        state <= 3'b001; // remain in state B
                end
                
                3'b010: begin // state C
                    if (x)
                        state <= 3'b001; // transition to state B
                    else
                        state <= 3'b010; // remain in state C
                end
                
                3'b011: begin // state D
                    if (x)
                        state <= 3'b010; // transition to state C
                    else
                        state <= 3'b001; // remain in state D
                end
                
                3'b100: begin // state E
                    if (x)
                        state <= 3'b100; // remain in state E
                    else
                        state <= 3'b011; // transition to state D
                end
                
                default: state <= 3'b000; // default case (should not happen)
            endcase
        end
    end

    always @(posedge clk) begin
        if (state == 3'b100 || state == 3'b101)
            z <= 1'b1;
        else
            z <= 1'b0;
    end
    
endmodule
