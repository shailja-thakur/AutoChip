module top_module (
    input clock,
    input reset,
    output reg data_out,
    output reg valid_out
);

    reg [1:0] state;
    reg [7:0] counter;

    parameter IDLE = 2'b00;
    parameter WAIT = 2'b01;
    parameter PROCESS = 2'b10;
    parameter DONE = 2'b11;

    initial begin
        state = IDLE;
        counter = 0;
        data_out = 0;
        valid_out = 0;
    end

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state = IDLE;
            counter = 0;
            data_out = 0;
            valid_out = 0;
        end
        else begin
            case (state)
                IDLE: begin
                    counter = 0;
                    data_out = 0;
                    valid_out = 0;
                    state = WAIT;
                end
                WAIT: begin
                    counter = counter + 1;
                    data_out = 0;
                    valid_out = 0;
                    if (counter == 8'd255) begin
                        state = PROCESS;
                    end
                end
                PROCESS: begin
                    data_out = 8'h55; // Replace with your processing logic
                    valid_out = 1;
                    state = DONE;
                end
                DONE: begin
                    data_out = 0;
                    valid_out = 0;
                    state = IDLE;
                end
                default: begin
                    state = IDLE;
                end
            endcase
        end
    end

endmodule
