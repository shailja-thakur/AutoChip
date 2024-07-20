module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // Define the state encoding
    typedef enum logic [1:0] {
        BYTE1 = 2'd0,
        BYTE2 = 2'd1,
        BYTE3 = 2'd2,
        DONE  = 2'd3
    } state_t;

    state_t current_state, next_state;
    reg [23:0] shift_register;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BYTE1;
            shift_register <= 24'd0;
            out_bytes <= 24'd0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;

            if (current_state != DONE) begin
                shift_register <= {shift_register[15:0], in};
            end

            if (current_state == DONE) begin
                out_bytes <= shift_register;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always_comb begin
        case (current_state)
            BYTE1: begin
                if (in[2] == 1'b1) 
                    next_state = BYTE2;
                else 
                    next_state = BYTE1;
            end

            BYTE2: begin
                next_state = BYTE3;
            end

            BYTE3: begin
                next_state = DONE;
            end

            DONE: begin
                next_state = BYTE1;
            end

            default: begin
                next_state = BYTE1;
            end
        endcase
    end

endmodule
