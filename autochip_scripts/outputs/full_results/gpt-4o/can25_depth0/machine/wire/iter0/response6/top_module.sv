module top_module(
    input wire clk,
    input wire rst,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State encoding
    localparam IDLE = 2'b00, WAIT = 2'b01, PROCESS = 2'b10, DONE = 2'b11;

    // Internal signals
    reg [1:0] state, next_state;
    reg [7:0] counter;

    // State transition logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state and output logic
    always @(*) begin
        // Default values
        next_state = state;
        data_out = 8'b0;
        valid_out = 1'b0;

        case (state)
            IDLE: begin
                counter = 8'b0;
                if (!rst) begin
                    next_state = WAIT;
                end
            end

            WAIT: begin
                counter = counter + 1;
                if (counter == 8'd255) begin
                    next_state = PROCESS;
                end
            end

            PROCESS: begin
                data_out = 8'hAA; // Example data to be processed
                next_state = DONE;
            end

            DONE: begin
                valid_out = 1'b1;
                next_state = IDLE;
            end
        endcase
    end

    // Counter logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 8'b0;
        end else if (state == WAIT) begin
            counter <= counter + 1;
        end else begin
            counter <= 8'b0;
        end
    end

endmodule
