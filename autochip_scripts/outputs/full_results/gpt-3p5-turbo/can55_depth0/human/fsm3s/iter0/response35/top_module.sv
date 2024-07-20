module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // Define the states
    typedef enum logic [1:0] {
        STATE_A,
        STATE_B,
        STATE_C,
        STATE_D
    } state_type;

    // Define the signals
    reg state_type current_state, next_state;
    reg out_reg;

    // Assign initial values
    initial begin
        current_state = STATE_A;
        out_reg = 1'b0;
    end

    // Sequential logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            out_reg <= 1'b0;
        end else begin
            current_state <= next_state;
            out_reg <= (current_state == STATE_D) ? 1'b1 : 1'b0;
        end
    end

    // Combinational logic
    always @* begin
        case (current_state)
            STATE_A: begin
                next_state = in ? STATE_B : STATE_A;
            end
            STATE_B: begin
                next_state = in ? STATE_B : STATE_C;
            end
            STATE_C: begin
                next_state = in ? STATE_D : STATE_A;
            end
            STATE_D: begin
                next_state = in ? STATE_B : STATE_C;
            end
        endcase
    end

    // Output assignment
    assign out = out_reg;

endmodule
