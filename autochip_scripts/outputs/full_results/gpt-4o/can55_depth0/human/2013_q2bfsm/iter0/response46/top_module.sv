module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State encoding
    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101,
        STATE_G = 3'b110
    } state_t;

    state_t state, next_state;
    
    reg [2:0] counter_x;
    reg [1:0] counter_y;

    // Monitor x values
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A;
            counter_x <= 3'b000;
        end else begin
            case (state)
                STATE_A: state <= STATE_B;
                STATE_B: begin
                    state <= STATE_C;
                    f <= 1;
                end
                STATE_C: begin
                    if (x == 1)
                        counter_x[2] <= 1;
                    state <= STATE_D;
                end
                STATE_D: begin
                    if (x == 0)
                        counter_x[1] <= 1;
                    else
                        counter_x[2:1] <= {counter_x[2], x};
                    state <= STATE_E;
                end
                STATE_E: begin
                    if (x == 1)
                        counter_x[0] <= 1;
                    else
                        counter_x[2:0] <= {counter_x[1], counter_x[0], x};
                    if (counter_x == 3'b101)
                        state <= STATE_F;
                    else
                        state <= STATE_C;
                end
                STATE_F: begin
                    g <= 1;
                    counter_y <= 2'b00;
                    state <= STATE_G;
                end
                STATE_G: begin
                    if (y == 1) begin
                        state <= STATE_G;
                    end else if (counter_y == 2'b10) begin
                        g <= 0;
                    end
                    counter_y <= counter_y + 1;
                end
                default: state <= STATE_A;
            endcase

            // Set f to 0 after one clock cycle
            if (f == 1 && state != STATE_B) begin
                f <= 0;
            end
        end
    end
endmodule
