module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// Define the states of the state machine
localparam [2:0] A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;

// Current state register
reg [2:0] current_state;

always @(posedge clk) begin
    if (reset) begin
        // Reset the state machine to state A
        current_state <= A;
    end
    else begin
        // Update the state based on the current state and the input w
        case (current_state)
            A: begin
                if (w) begin
                    current_state <= A;
                end
                else begin
                    current_state <= B;
                end
            end
            B: begin
                if (w) begin
                    current_state <= D;
                end
                else begin
                    current_state <= C;
                end
            end
            C: begin
                if (w) begin
                    current_state <= D;
                end
                else begin
                    current_state <= E;
                end
            end
            D: begin
                if (w) begin
                    current_state <= A;
                end
                else begin
                    current_state <= F;
                end
            end
            E: begin
                if (w) begin
                    current_state <= D;
                end
                else begin
                    current_state <= E;
                end
            end
            F: begin
                if (w) begin
                    current_state <= D;
                end
                else begin
                    current_state <= C;
                end
            end
            default: current_state <= A;
        endcase
    end
end

// Assign the output z based on the current state
always @(*) begin
    case (current_state)
        E, F: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
