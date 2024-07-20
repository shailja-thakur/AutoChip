module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State encoding
    typedef enum logic [3:0] {
        STATE_A = 4'd0,
        STATE_B = 4'd1,
        STATE_C = 4'd2,
        STATE_D = 4'd3,
        STATE_E = 4'd4,
        STATE_F = 4'd5,
        STATE_G = 4'd6
    } state_t;

    state_t current_state, next_state;
    reg [1:0] x_sequence;
    reg [1:0] y_counter;

    // State transition and output logic
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 0;
            g <= 0;
            x_sequence <= 2'b00;
            y_counter <= 2'b00;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        case (current_state)

            STATE_A: begin
                f <= 0;
                g <= 0;
                if (!resetn) next_state <= STATE_A;
                else next_state <= STATE_B;
            end

            STATE_B: begin
                f <= 1;
                next_state <= STATE_C;
            end

            STATE_C: begin
                f <= 0;
                if (x) x_sequence <= 2'b01;
                next_state <= STATE_D;
            end

            STATE_D: begin
                if (x_sequence == 2'b01 && !x) begin
                    x_sequence <= 2'b11;
                    next_state <= STATE_E;
                end else next_state <= STATE_C;
            end

            STATE_E: begin
                g <= 0;
                if (x_sequence == 2'b11 && x) begin
                    g <= 1;
                    next_state <= STATE_F;
                end else next_state <= STATE_C;
            end

            STATE_F: begin
                if (y) g <= 1;  // Maintain g = 1 permanently
                y_counter <= y_counter + 1;

                if (y_counter == 2'd2 && !y) begin
                    g <= 0;
                    next_state <= STATE_G;
                end else if (y_counter < 2'd2 && y) begin
                    g <= 1;
                    next_state <= STATE_F;
                end
            end

            STATE_G: begin
                g <= 0;
            end

            default: next_state <= STATE_A;

        endcase
    end

endmodule
