module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

localparam STATE_A = 2'b00; // Reset state
localparam STATE_B = 2'b01; // Set f to 1 for one clock cycle
localparam STATE_C = 2'b10; // Monitoring x for 1, 0, 1 pattern
localparam STATE_D = 2'b11; // Monitoring y to set g permanently

reg [1:0] current_state, next_state;
reg [1:0] x_count;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        current_state <= STATE_A;
        x_count <= 0;
        f <= 0;
        g <= 0;
    end
    else begin
        current_state <= next_state;
        case (current_state)
            STATE_A: begin
                f <= 0;
                g <= 0;
            end
            STATE_B: begin
                f <= 1;
            end
            STATE_C: begin
                if (x_count == 2'd2 && x == 1) begin
                    next_state <= STATE_D;
                    g <= 1;
                end
                else begin
                    x_count <= x_count + 1;
                end
            end
            STATE_D: begin
                if (y == 1) begin
                    g <= 1;
                end
                else begin
                    g <= 0;
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
            next_state = (x_count == 2'd2 && x == 1) ? STATE_D : STATE_C;
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
