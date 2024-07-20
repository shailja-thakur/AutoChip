module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // Parameters for state encoding
    parameter IDLE = 2'b00,
              WAIT = 2'b01,
              PROCESS = 2'b10,
              DONE = 2'b11;

    reg [1:0] state, next_state;
    reg [3:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
        end else begin
            state <= next_state;
            if (state == WAIT) begin
                counter <= counter + 1;
            end else begin
                counter <= 0;
            end
        end
    end

    always @(*) begin
        next_state = state;
        data_out = 8'b0;
        valid_out = 1'b0;
        case (state)
            IDLE: begin
                if (reset) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT;
                end
            end
            WAIT: begin
                if (counter >= 4'd10) begin
                    next_state = PROCESS;
                end
                data_out = 8'b0;
                valid_out = 1'b0;
            end
            PROCESS: begin
                data_out = 8'hFF; // Assuming some processed data.
                next_state = DONE;
            end
            DONE: begin
                valid_out = 1'b1;
                next_state = IDLE;
            end
        endcase
    end
endmodule
