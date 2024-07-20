module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    reg [2:0] state;
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000;    // Initial state A
        else begin
            case(state)
                3'b000: if (w) state <= 3'b001;  // A to B
                        else   state <= 3'b000;  // A to A
                3'b001: if (w) state <= 3'b010;  // B to C
                        else   state <= 3'b100;  // B to D
                3'b010: if (w) state <= 3'b101;  // C to E
                        else   state <= 3'b100;  // C to D
                3'b100: if (w) state <= 3'b111;  // D to F
                        else   state <= 3'b000;  // D to A
                3'b101: if (w) state <= 3'b101;  // E to E
                        else   state <= 3'b100;  // E to D
                3'b111: if (w) state <= 3'b011;  // F to C
                        else   state <= 3'b100;  // F to D
            endcase
        end
    end
    
    always @(state) begin
        if (state == 3'b101 || state == 3'b111)
            z <= 1'b1;
        else
            z <= 1'b0;
    end
    
endmodule
