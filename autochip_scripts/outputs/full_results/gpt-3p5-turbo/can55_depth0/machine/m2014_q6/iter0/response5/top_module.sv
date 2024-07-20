module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    reg [2:0] state;
    always @(posedge clk) begin
        if (reset)
            state <= 3'b000; // Reset to state A
        else begin
            case (state)
                3'b000: state <= (w == 1'b0) ? 3'b001 : 3'b000; // Transition from state A to B (w low), otherwise stay in state A
                3'b001: state <= (w == 1'b1) ? 3'b100 : 3'b010; // Transition from state B to D (w high), transition from state B to C (w low)
                3'b010: state <= (w == 1'b1) ? 3'b100 : 3'b011; // Transition from state C to D (w high), transition from state C to E (w low)
                3'b011: state <= (w == 1'b1) ? 3'b000 : 3'b100; // Transition from state D to A (w high), transition from state D to F (w low)
                3'b100: state <= (w == 1'b1) ? 3'b010 : 3'b101; // Transition from state E to D (w high), transition from state E to E (w low)
                3'b101: state <= (w == 1'b1) ? 3'b100 : 3'b010; // Transition from state F to D (w high), transition from state F to C (w low)
            endcase
        end
    end

    always @(state) begin
        z = (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0; // Output z is high when the state machine is in state E or F, and low otherwise
    end
    
endmodule
