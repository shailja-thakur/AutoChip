module top_module(
    input clk,
    input reset,
    output reg data_out,
    output reg valid_out
);

    reg [1:0] state, next_state;
    reg [3:0] counter;

    // State Encoding
    localparam IDLE = 2'b00,
               WAIT = 2'b01,
               PROCESS = 2'b10,
               DONE = 2'b11;

    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0000;
        end else begin
            state <= next_state;
        end
    end

    // Next State and Output Logic
    always @(*) begin
        next_state = state;
        data_out = 1'b0;
        valid_out = 1'b0;
        case (state)
            IDLE: begin
                next_state = WAIT;
                counter = 4'b0000;
                data_out = 1'b0;
            end
            WAIT: begin
                if (counter == 4'b1111) begin
                    next_state = PROCESS;
                end else begin
                    counter = counter + 1;
                end
            end
            PROCESS: begin
                data_out = /* data that is being processed by the module */;
                next_state = DONE;
            end
            DONE: begin
                valid_out = 1'b1;
                next_state = IDLE;
            end
        endcase
    end
endmodule
