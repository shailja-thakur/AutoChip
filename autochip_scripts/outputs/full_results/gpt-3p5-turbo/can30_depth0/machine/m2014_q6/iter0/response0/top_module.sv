module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// Define the states as parameters
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter D = 3;
parameter E = 4;
parameter F = 5;

// Define the current and next state variables
reg [2:0] state;
reg [2:0] next_state;

// Assign initial state
initial begin
    state = A;
end

// Assign next state based on current state and input w
always @(posedge clk) begin
    if (reset) begin
        state <= A;
    end else begin
        case(state)
            A: begin
                if (w == 0) begin
                    next_state <= B;
                end else begin
                    next_state <= A;
                end
            end

            B: begin
                if (w == 1) begin
                    next_state <= C;
                end else begin
                    next_state <= D;
                end
            end

            C: begin
                if (w == 1) begin
                    next_state <= D;
                end else begin
                    next_state <= E;
                end
            end

            D: begin
                if (w == 1) begin
                    next_state <= A;
                end else begin
                    next_state <= F;
                end
            end

            E: begin
                if (w == 1) begin
                    next_state <= D;
                end else begin
                    next_state <= E;
                end
            end

            F: begin
                if (w == 1) begin
                    next_state <= D;
                end else begin
                    next_state <= C;
                end
            end
        endcase
    end
end

// Update state based on next state
always @(posedge clk) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// Assign output z based on current state
always @(posedge clk) begin
    case(state)
        E, F: begin
            z <= 1;
        end

        default: begin
            z <= 0;
        end
    endcase
end

endmodule
