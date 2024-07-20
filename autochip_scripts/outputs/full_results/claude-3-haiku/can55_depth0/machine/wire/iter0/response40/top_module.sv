module top_module(
    input clock,
    input reset,
    output reg data_out,
    output reg valid_out
);

reg [1:0] state;
reg [3:0] counter;

localparam IDLE = 2'b00;
localparam WAIT = 2'b01;
localparam PROCESS = 2'b10;
localparam DONE = 2'b11;

always @(posedge clock or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counter <= 0;
        data_out <= 0;
        valid_out <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                state <= WAIT;
            end
            WAIT: begin
                counter <= counter + 1;
                data_out <= 0;
                if (counter == 4'd10) begin
                    state <= PROCESS;
                end
            end
            PROCESS: begin
                data_out <= in;
                state <= DONE;
            end
            DONE: begin
                valid_out <= 1;
                state <= IDLE;
                counter <= 0;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
