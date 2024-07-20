module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State definitions
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    // Internal signals
    reg [1:0] state, next_state;
    reg [7:0] counter;

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (reset)
                    next_state = IDLE;
                else
                    next_state = WAIT;
            end
            WAIT: begin
                if (counter == 8'd255)
                    next_state = PROCESS;
                else
                    next_state = WAIT;
            end
            PROCESS: begin
                next_state = DONE;
            end
            DONE: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // State register and counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'd0;
        end
        else begin
            state <= next_state;
            if (state == WAIT && next_state == WAIT)
                counter <= counter + 8'd1;
            else
                counter <= 8'd0;
        end
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 8'd0;
            valid_out <= 1'b0;
        end
        else begin
            case (state)
                IDLE: begin
                    data_out <= 8'd0;
                    valid_out <= 1'b0;
                end
                WAIT: begin
                    data_out <= 8'd0;
                    valid_out <= 1'b0;
                end
                PROCESS: begin
                    data_out <= 8'hA5; // Example data
                    valid_out <= 1'b0;
                end
                DONE: begin
                    data_out <= data_out;
                    valid_out <= 1'b1;
                end
                default: begin
                    data_out <= 8'd0;
                    valid_out <= 1'b0;
                end
            endcase
        end
    end
endmodule
