module top_module (
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // Internal signals
    reg [1:0] state, next_state;
    reg [3:0] counter;

    // State encoding
    localparam IDLE = 2'b00,
               WAIT = 2'b01,
               PROCESS = 2'b10,
               DONE = 2'b11;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0000;
            data_out <= 8'b00000000;
            valid_out <= 1'b0;
        end else begin
            state <= next_state;
            if (next_state == WAIT) begin
                counter <= counter + 1;
            end else if (next_state == IDLE) begin
                counter <= 4'b0000;
            end
        end
    end

    // Next state logic and outputs
    always @(*) begin
        case (state)
            IDLE: begin
                next_state = WAIT;
                data_out = 8'b00000000;
                valid_out = 1'b0;
            end
            WAIT: begin
                if (counter < 4'b1111) begin
                    next_state = WAIT;
                end else begin
                    next_state = PROCESS;
                end
                data_out = 8'b00000000;
                valid_out = 1'b0;
            end
            PROCESS: begin
                next_state = DONE;
                data_out = 8'b11111111; // Assuming the data to be processed is 8'b11111111
                valid_out = 1'b0;
            end
            DONE: begin
                next_state = IDLE;
                valid_out = 1'b1;
            end
            default: begin
                next_state = IDLE;
                data_out = 8'b00000000;
                valid_out = 1'b0;
            end
        endcase
    end

endmodule
