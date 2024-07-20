module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// Declare state register and define states
reg [2:0] state;
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

always @(posedge clk) begin
    if (reset) begin
        state <= A;  // Reset to state A
    end else begin
        case(state)
            A: begin
                if (w) begin
                    state <= A;  // Transition from A to A
                end else begin
                    state <= B;  // Transition from A to B
                end
            end
            
            B: begin
                if (w) begin
                    state <= D;  // Transition from B to D
                end else begin
                    state <= C;  // Transition from B to C
                end
            end
            
            C: begin
                if (w) begin
                    state <= D;  // Transition from C to D
                end else begin
                    state <= E;  // Transition from C to E
                end
            end
            
            D: begin
                if (w) begin
                    state <= A;  // Transition from D to A
                end else begin
                    state <= F;  // Transition from D to F
                end
            end
            
            E: begin
                if (w) begin
                    state <= D;  // Transition from E to D
                end else begin
                    state <= E;  // Transition from E to E
                end
            end
            
            F: begin
                if (w) begin
                    state <= D;  // Transition from F to D
                end else begin
                    state <= C;  // Transition from F to C
                end
            end
        endcase
    end
end

// Output z is high when in state E or F, low otherwise
always @(state) begin
    if (state == E || state == F) begin
        z <= 1'b1;
    end else begin
        z <= 1'b0;
    end
end

endmodule
