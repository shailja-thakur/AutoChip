module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states of the state machine
localparam S0 = 2'b00, // Initial state
          S1 = 2'b01, // Processing state
          S2 = 2'b10; // Output state

reg [1:0] state, next_state;
reg [7:0] accumulator;
reg [3:0] bit_count;

// State update logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= S0;
        accumulator <= 8'b0;
        bit_count <= 4'b0;
    end
    else begin
        state <= next_state;
        case (state)
            S0: begin
                accumulator <= 8'b0;
                bit_count <= 4'b0;
            end
            S1: begin
                accumulator <= {accumulator[6:0], x};
                bit_count <= bit_count + 1'b1;
            end
            S2: begin
                z <= ~accumulator[7] ? accumulator : ~accumulator + 1'b1;
            end
        endcase
    end
end

// Next state logic
always @(*) begin
    case (state)
        S0: begin
            if (~areset) begin
                next_state = S1;
            end
            else begin
                next_state = S0;
            end
        end
        S1: begin
            if (bit_count == 4'd8) begin
                next_state = S2;
            end
            else begin
                next_state = S1;
            end
        end
        S2: begin
            next_state = S0;
        end
        default: begin
            next_state = S0;
        end
    endcase
end

endmodule
