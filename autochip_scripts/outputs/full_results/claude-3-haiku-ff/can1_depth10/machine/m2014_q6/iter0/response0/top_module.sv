module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// Define the states of the state machine
localparam [2:0] A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

// Declare the state register
reg [2:0] state;

always @(posedge clk) begin
    if (reset) begin
        // Reset the state machine to state A
        state <= A;
    end
    else begin
        // Transition to the next state based on the current state and the input w
        case (state)
            A: begin
                if (w) begin
                    state <= A;
                end
                else begin
                    state <= B;
                end
            end
            B: begin
                if (w) begin
                    state <= D;
                end
                else begin
                    state <= C;
                end
            end
            C: begin
                if (w) begin
                    state <= D;
                end
                else begin
                    state <= E;
                end
            end
            D: begin
                if (w) begin
                    state <= A;
                end
                else begin
                    state <= F;
                end
            end
            E: begin
                if (w) begin
                    state <= D;
                end
                else begin
                    state <= E;
                end
            end
            F: begin
                if (w) begin
                    state <= D;
                end
                else begin
                    state <= C;
                end
            end
            default: begin
                state <= A;
            end
        endcase
    end
end

// Set the output z based on the current state
always @(*) begin
    case (state)
        E, F: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
