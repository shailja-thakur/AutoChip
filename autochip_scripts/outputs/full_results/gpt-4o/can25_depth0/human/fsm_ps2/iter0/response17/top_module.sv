module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // State encoding
    typedef enum reg [1:0] {
        WAIT_FOR_FIRST_BYTE = 2'b00,
        BYTE_1_RECEIVED = 2'b01,
        BYTE_2_RECEIVED = 2'b10,
        BYTE_3_RECEIVED = 2'b11
    } state_t;

    state_t state, next_state;
   
    // Output signal
    reg done_reg;
    assign done = done_reg;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_FOR_FIRST_BYTE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        done_reg = 1'b0;
        case (state)
            WAIT_FOR_FIRST_BYTE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE_1_RECEIVED;
                end else begin
                    next_state = WAIT_FOR_FIRST_BYTE;
                end
            end

            BYTE_1_RECEIVED: begin
                if (reset) begin
                    next_state = WAIT_FOR_FIRST_BYTE;
                end else begin
                    next_state = BYTE_2_RECEIVED;
                end
            end

            BYTE_2_RECEIVED: begin
                if (reset) begin
                    next_state = WAIT_FOR_FIRST_BYTE;
                end else begin
                    next_state = BYTE_3_RECEIVED;
                end
            end

            BYTE_3_RECEIVED: begin
                if (reset) begin
                    next_state = WAIT_FOR_FIRST_BYTE;
                end else begin
                    next_state = WAIT_FOR_FIRST_BYTE;
                    done_reg = 1'b1; // Signal done
                end
            end

        endcase
    end

endmodule
