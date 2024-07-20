module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    
    reg [2:0] state; // register to store the current state

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000; // reset the state to A
        else begin
            case (state)
                3'b000:
                    if (w)
                        state <= 3'b001; // A to B
                    else
                        state <= 3'b000; // A to A
                3'b001:
                    if (w)
                        state <= 3'b010; // B to C
                    else
                        state <= 3'b011; // B to D
                3'b010:
                    if (w)
                        state <= 3'b110; // C to E
                    else
                        state <= 3'b011; // C to D
                3'b011:
                    if (w)
                        state <= 3'b001; // D to B
                    else
                        state <= 3'b000; // D to A
                3'b100:
                    if (w)
                        state <= 3'b100; // E to E
                    else
                        state <= 3'b011; // E to D
                3'b101:
                    if (w)
                        state <= 3'b011; // F to D
                    else
                        state <= 3'b110; // F to C
            endcase
        end
    end
    
    always @(state) begin
        if (state == 3'b100 || state == 3'b101)
            z = 1;
        else
            z = 0;
    end

endmodule
