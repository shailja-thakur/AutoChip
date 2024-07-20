module top_module (
    input clk,
    input reset,
    input w,
    output z
);
    
    reg [2:0] state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000; // state A
        end else begin
            case (state)
                3'b000: // state A
                    if (w == 1'b0) begin
                        state <= 3'b010; // transition to state B
                    end else begin
                        state <= 3'b000; // stay in state A
                    end
                3'b010: // state B
                    if (w == 1'b1) begin
                        state <= 3'b001; // transition to state D
                    end else begin
                        state <= 3'b011; // transition to state C
                    end
                3'b011: // state C
                    if (w == 1'b1) begin
                        state <= 3'b001; // transition to state D
                    end else begin
                        state <= 3'b100; // transition to state E
                    end
                3'b001: // state D
                    if (w == 1'b1) begin
                        state <= 3'b000; // transition to state A
                    end else begin
                        state <= 3'b101; // transition to state F
                    end
                3'b100: // state E
                    if (w == 1'b1) begin
                        state <= 3'b001; // transition to state D
                    end else begin
                        state <= 3'b100; // stay in state E
                    end
                3'b101: // state F
                    if (w == 1'b1) begin
                        state <= 3'b001; // transition to state D
                    end else begin
                        state <= 3'b011; // transition to state C
                    end
            endcase
        end
    end
    
    assign z = (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0;
  
endmodule
