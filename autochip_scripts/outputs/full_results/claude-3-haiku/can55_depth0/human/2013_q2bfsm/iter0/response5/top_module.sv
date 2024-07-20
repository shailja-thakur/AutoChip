module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

// Define the states of the FSM
localparam STATE_A = 2'b00; // Initial state
localparam STATE_B = 2'b01; // After f = 1 for one cycle
localparam STATE_C = 2'b10; // After x = 1, 0, 1 sequence
localparam STATE_D = 2'b11; // After y = 1 within two cycles

reg [1:0] state, next_state;
reg [1:0] x_count;

always @(posedge clk) begin
    if (!resetn) begin
        state <= STATE_A;
        f <= 0;
        g <= 0;
        x_count <= 0;
    end
    else begin
        state <= next_state;

        case (state)
            STATE_A: begin
                f <= 0;
                g <= 0;
                x_count <= 0;
            end
            STATE_B: begin
                f <= 1; // Set f = 1 for one cycle
                g <= 0;
                x_count <= 0;
            end
            STATE_C: begin
                f <= 0;
                if (y == 1) begin
                    g <= 1; // Set g = 1 permanently
                end
                else begin
                    g <= 0; // Set g = 0 permanently
                end
                x_count <= 0;
            end
            STATE_D: begin
                f <= 0;
                g <= 1; // Maintain g = 1 permanently
                x_count <= 0;
            end
        endcase
    end
end

// Next state logic
always @(*) begin
    case (state)
        STATE_A: begin
            if (resetn) begin
                next_state = STATE_B;
            end
            else begin
                next_state = STATE_A;
            end
        end
        STATE_B: begin
            next_state = STATE_C;
        end
        STATE_C: begin
            if (x == 1) begin
                x_count <= x_count + 1;
                if (x_count == 2) begin
                    next_state = STATE_D;
                end
                else begin
                    next_state = STATE_C;
                end
            end
            else begin
                x_count <= 0;
                next_state = STATE_C;
            end
        end
        STATE_D: begin
            next_state = STATE_D;
        end
        default: begin
            next_state = STATE_A;
        end
    endcase
end

endmodule
