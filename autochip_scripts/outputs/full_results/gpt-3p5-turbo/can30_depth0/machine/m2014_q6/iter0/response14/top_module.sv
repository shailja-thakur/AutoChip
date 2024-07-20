module top_module (
    input clk,
    input reset,
    input w,
    output z
);
    
    reg [2:0] state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000; // Reset to state A
        end else begin
            case (state)
                3'b000: if (w == 1'b0) state <= 3'b010; else state <= 3'b000; // Transition from A to B or stay in A
                3'b010: if (w == 1'b1) state <= 3'b001; else state <= 3'b011; // Transition from B to A or C
                3'b011: if (w == 1'b0) state <= 3'b100; else state <= 3'b011; // Transition from C to D or stay in C
                3'b100: if (w == 1'b1) state <= 3'b000; else state <= 3'b101; // Transition from D to A or F
                3'b101: if (w == 1'b0) state <= 3'b100; else state <= 3'b101; // Transition from F to D or stay in F
                3'b110: if (w == 1'b1) state <= 3'b011; else state <= 3'b110; // Transition from E to C or stay in E
                default: state <= 3'b000; // Default case: reset to state A
            endcase
        end
    end
    
    assign z = (state == 3'b101 || state == 3'b110) ? 1'b1 : 1'b0; // Output z is high in states E and F, low otherwise
    
endmodule
