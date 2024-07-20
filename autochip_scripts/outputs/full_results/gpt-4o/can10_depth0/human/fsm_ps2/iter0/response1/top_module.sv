module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t current_state, next_state;
    reg [1:0] byte_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1)
                    next_state = BYTE1;
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = DONE;
            end
            DONE: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            byte_count <= 2'b00;
        end else begin
            case (current_state)
                IDLE: begin
                    if (in[3] == 1'b1)
                        byte_count <= 2'b01;
                    else
                        byte_count <= 2'b00;
                end
                BYTE1: begin
                    byte_count <= byte_count + 1;
                end
                BYTE2: begin
                    byte_count <= byte_count + 1;
                end
                DONE: begin
                    byte_count <= 2'b00;
                end
                default: byte_count <= 2'b00;
            endcase
        end
    end

    assign done = (current_state == DONE);

endmodule
