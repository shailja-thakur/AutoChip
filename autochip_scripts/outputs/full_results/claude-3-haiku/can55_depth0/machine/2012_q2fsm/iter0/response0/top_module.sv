module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    reg [2:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000; // state A
        end
        else begin
            case (state)
                3'b000: // state A
                    if (w == 1'b0) begin
                        state <= 3'b000; // state A
                    end
                    else begin
                        state <= 3'b001; // state B
                    end
                3'b001: // state B
                    if (w == 1'b0) begin
                        state <= 3'b011; // state D
                    end
                    else begin
                        state <= 3'b010; // state C
                    end
                3'b010: // state C
                    if (w == 1'b0) begin
                        state <= 3'b011; // state D
                    end
                    else begin
                        state <= 3'b100; // state E
                    end
                3'b011: // state D
                    if (w == 1'b0) begin
                        state <= 3'b000; // state A
                    end
                    else begin
                        state <= 3'b101; // state F
                    end
                3'b100: // state E
                    if (w == 1'b0) begin
                        state <= 3'b011; // state D
                    end
                    else begin
                        state <= 3'b100; // state E
                    end
                3'b101: // state F
                    if (w == 1'b0) begin
                        state <= 3'b011; // state D
                    end
                    else begin
                        state <= 3'b010; // state C
                    end
            endcase
        end
    end

    assign z = (state == 3'b100) || (state == 3'b101); // z is 1 when in state E or F

endmodule
