module top_module(
    input            clk,
    input            reset,
    output reg [7:0] data_out,
    output reg       valid_out
);

    // State encoding
    localparam IDLE    = 2'b00;
    localparam WAIT    = 2'b01;
    localparam PROCESS = 2'b10;
    localparam DONE    = 2'b11;

    reg [1:0] state, next_state;
    reg [3:0] counter;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0000;
        end else begin
            state <= next_state;
        end
    end

    // Next state and output logic
    always @(*) begin
        // Default values
        next_state = state;
        data_out = 8'b00000000;
        valid_out = 1'b0;

        case (state)
            IDLE: begin
                counter = 4'b0000;
                data_out = 8'b00000000;
                if (!reset)
                    next_state = WAIT;
            end

            WAIT: begin
                counter = counter + 1;
                data_out = 8'b00000000;
                if (counter == 4'b1111)
                    next_state = PROCESS;
            end

            PROCESS: begin
                data_out = 8'b10101010; // Example data processing
                next_state = DONE;
            end

            DONE: begin
                valid_out = 1'b1;
                next_state = IDLE;
            end
        endcase
    end

endmodule
