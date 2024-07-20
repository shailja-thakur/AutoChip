module top_module(
    input clock,
    input reset,
    output reg [31:0] data_output,
    output reg valid_output
);

reg [1:0] state;
reg [31:0] counter;

localparam IDLE = 2'b00;
localparam WAIT = 2'b01;
localparam PROCESS = 2'b10;
localparam DONE = 2'b11;

always @(posedge clock or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counter <= 0;
        data_output <= 0;
        valid_output <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                counter <= 0;
                data_output <= 0;
                valid_output <= 0;
                state <= WAIT;
            end
            WAIT: begin
                counter <= counter + 1;
                data_output <= 0;
                if (counter == 32'd1000) begin
                    state <= PROCESS;
                end
                else begin
                    state <= WAIT;
                end
            end
            PROCESS: begin
                data_output <= 32'hdeadbeef; // Set the data output to the desired value
                state <= DONE;
            end
            DONE: begin
                valid_output <= 1;
                state <= IDLE;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
