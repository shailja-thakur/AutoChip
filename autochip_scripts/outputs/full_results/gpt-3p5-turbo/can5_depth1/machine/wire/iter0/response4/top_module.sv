module top_module(
    input clock,
    input reset,
    output reg data_output,
    output reg valid_output
);

reg [1:0] state;
reg [7:0] counter;

parameter idle = 2'b00;
parameter wait = 2'b01;
parameter process = 2'b10;
parameter done = 2'b11;

always @(posedge clock or posedge reset) begin
    if (reset) begin
        state <= idle;
        counter <= 8'b0;
        data_output <= 1'b0;
        valid_output <= 1'b0;
    end else begin
        case (state)
            idle: begin
                counter <= 8'b0;
                data_output <= 1'b0;
                valid_output <= 1'b0;
                if (in) begin
                    state <= wait;
                end
            end
            wait: begin
                counter <= counter + 1'b1;
                data_output <= 1'b0;
                valid_output <= 1'b0;
                if (counter == 8'hFF) begin
                    state <= process;
                end
            end
            process: begin
                data_output <= in;
                state <= done;
            end
            done: begin
                valid_output <= 1'b1;
                state <= idle;
            end
            default: state <= idle;
        endcase
    end
end

endmodule
