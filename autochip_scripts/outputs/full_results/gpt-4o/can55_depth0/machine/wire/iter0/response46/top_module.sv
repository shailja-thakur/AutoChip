module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
    );

    // State encoding
    localparam IDLE    = 2'b00;
    localparam WAIT    = 2'b01;
    localparam PROCESS = 2'b10;
    localparam DONE    = 2'b11;

    // Internal signals
    reg [1:0] state, next_state;
    reg [3:0] counter; // Increase or decrease the counter width as needed

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0000;
            data_out <= 8'b00000000;
            valid_out <= 1'b0;
        end else begin
            state <= next_state;

            if (state == IDLE) begin
                counter <= 4'b0000;
                data_out <= 8'b00000000;
                valid_out <= 1'b0;
            end else if (state == WAIT) begin
                counter <= counter + 1;
                data_out <= 8'b00000000;
                valid_out <= 1'b0;
            end else if (state == PROCESS) begin
                data_out <= 8'b10101010; // Example processed data, replace with actual processing logic
                valid_out <= 1'b0;
            end else if (state == DONE) begin
                valid_out <= 1'b1;
            end
        end
    end

    // Next state logic
    always @* begin
        case (state)
            IDLE: begin
                if (reset) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT;
                end
            end

            WAIT: begin
                if (counter == 4'b1111) begin // Replace with actual threshold value
                    next_state = PROCESS;
                end else begin
                    next_state = WAIT;
                end
            end

            PROCESS: begin
                next_state = DONE;
            end

            DONE: begin
                next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end
endmodule
