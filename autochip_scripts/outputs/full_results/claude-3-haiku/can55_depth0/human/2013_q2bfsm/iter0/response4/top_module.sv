module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

// Define the states of the finite state machine
parameter STATE_A = 2'b00; // Reset state
parameter STATE_B = 2'b01; // Output f = 1 for one clock cycle
parameter STATE_C = 2'b10; // Monitor x input for 1-0-1 pattern
parameter STATE_D = 2'b11; // Monitor y input for 1 within 2 clock cycles

reg [1:0] current_state, next_state;
reg [1:0] x_count;
reg [1:0] y_count;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        current_state <= STATE_A;
        x_count <= 0;
        y_count <= 0;
        f <= 0;
        g <= 0;
    end
    else begin
        current_state <= next_state;
        case (current_state)
            STATE_A: begin // Reset state
                f <= 0;
                g <= 0;
            end
            STATE_B: begin // Output f = 1 for one clock cycle
                f <= 1;
                g <= 0;
            end
            STATE_C: begin // Monitor x input for 1-0-1 pattern
                f <= 0;
                if (x == 1) begin
                    x_count <= x_count + 1;
                end
                else if (x == 0) begin
                    if (x_count == 1) begin
                        x_count <= x_count + 1;
                    end
                    else begin
                        x_count <= 0;
                    end
                end
                else begin
                    if (x_count == 2) begin
                        x_count <= 0;
                        g <= 1;
                    end
                    else begin
                        x_count <= 0;
                    end
                end
            end
            STATE_D: begin // Monitor y input for 1 within 2 clock cycles
                if (y == 1) begin
                    g <= 1;
                    y_count <= 0;
                end
                else begin
                    y_count <= y_count + 1;
                    if (y_count == 2) begin
                        g <= 0;
                    end
                end
            end
        endcase
    end
end

always @(*) begin
    case (current_state)
        STATE_A: begin
            next_state = (resetn) ? STATE_B : STATE_A;
        end
        STATE_B: begin
            next_state = STATE_C;
        end
        STATE_C: begin
            next_state = (x_count == 2) ? STATE_D : STATE_C;
        end
        STATE_D: begin
            next_state = (y_count == 2) ? STATE_A : STATE_D;
        end
        default: begin
            next_state = STATE_A;
        end
    endcase
end

endmodule
