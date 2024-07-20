module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    reg [2:0] state;
    reg [2:0] next_state;
    reg [5:0] count;

    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
            count <= 0;
        end
        else begin
            state <= next_state;
            count <= count + 1;
        end
    end

    always @(state, in, count) begin
        case (state)
            S0: begin
                disc = 0;
                flag = 0;
                err = 0;
                if (in) begin
                    next_state = S1;
                    count <= 1;
                end
                else begin
                    next_state = S0;
                    count <= 0;
                end
            end
            S1: begin
                disc = 0;
                flag = 0;
                err = 0;
                if (in) begin
                    next_state = S1;
                    count <= count + 1;
                end
                else begin
                    next_state = S2;
                    count <= 0;
                end
            end
            S2: begin
                disc = 0;
                flag = 0;
                err = 0;
                if (in) begin
                    next_state = S1;
                    count <= count + 1;
                end
                else if (count >= 5) begin
                    next_state = S3;
                    count <= 0;
                end
                else begin
                    next_state = S0;
                    count <= 0;
                end
            end
            S3: begin
                disc = 0;
                flag = 0;
                err = 0;
                if (in) begin
                    next_state = S4;
                    count <= 0;
                end
                else begin
                    next_state = S0;
                    count <= 0;
                end
            end
            S4: begin
                disc = 0;
                flag = 0;
                err = 0;
                if (in) begin
                    next_state = S1;
                    count <= 1;
                end
                else begin
                    next_state = S3;
                    count <= 0;
                end
            end
            default: begin
                disc = 0;
                flag = 0;
                err = 0;
                next_state = S0;
                count <= 0;
            end
        endcase
    end
endmodule
