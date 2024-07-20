module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [3:0] state;
reg [1:0] counter;

parameter S0 = 4'b0000;
parameter S1 = 4'b0001;
parameter S2 = 4'b0010;
parameter S3 = 4'b0011;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S0;
        counter <= 2'b00;
    end else begin
        state <= next_state;
        counter <= next_counter;
    end
end

always @(state, data) begin
    case (state)
        S0: begin
            if (data == 1'b1)
                next_state = S1;
            else
                next_state = S0;
        end
        S1: begin
            if (data == 1'b1)
                next_state = S1;
            else
                next_state = S2;
        end
        S2: begin
            if (data == 1'b1)
                next_state = S3;
            else
                next_state = S0;
        end
        S3: begin
            if (data == 1'b1) begin
                next_state = S3;
                if (counter == 2'b11)
                    next_counter = counter;
                else
                    next_counter = counter + 1;
            end else begin
                next_state = S0;
                next_counter = 2'b00;
            end
        end
        default: begin
            next_state = S0;
            next_counter = 2'b00;
        end
    endcase
end

always @(posedge clk) begin
    if (state == S3 && counter == 2'b11)
        start_shifting <= 1;
    else if (reset)
        start_shifting <= 0;
end

endmodule
