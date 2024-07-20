module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid
);

    reg [1:0] state;
    reg [7:0] counter;

    // FSM states
    localparam IDLE = 2'b00;
    localparam WAIT = 2'b01;
    localparam PROCESS = 2'b10;
    localparam DONE = 2'b11;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'b0;
            data_out <= 8'b0;
            valid <= 1'b0;
        end
        else begin
            case (state)
                IDLE: begin
                    state <= WAIT;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'b0;
                    if (counter == 8'd100) begin
                        state <= PROCESS;
                    end
                end
                PROCESS: begin
                    // Set the data_out value based on the processing logic
                    data_out <= 8'h55;
                    state <= DONE;
                end
                DONE: begin
                    valid <= 1'b1;
                    state <= IDLE;
                    counter <= 8'b0;
                end
                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
