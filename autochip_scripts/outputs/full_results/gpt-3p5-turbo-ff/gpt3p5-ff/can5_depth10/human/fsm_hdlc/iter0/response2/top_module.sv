module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    reg [2:0] state;
    reg disc_next;
    reg flag_next;
    reg err_next;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000;
        else
            state <= {state[1:0], in}; 
    end

    always @(state) begin
        disc_next = 0;
        flag_next = 0;
        err_next = 0;

        case (state)
            3'b000: begin
                disc_next = 0;
                flag_next = 0;
                err_next = 0;
            end
            3'b001: begin
                if (in)
                    state <= 3'b010;
                else begin
                    disc_next = 0;
                    flag_next = 0;
                    err_next = 0;
                end
            end
            3'b010: begin
                if (in)
                    state <= 3'b011;
                else
                    state <= 3'b000;
            end
            3'b011: begin
                if (in)
                    state <= 3'b100;
                else
                    state <= 3'b000;
            end
            3'b100: begin
                if (in)
                    state <= 3'b101;
                else
                    state <= 3'b000;
            end
            3'b101: begin
                if (in)
                    state <= 3'b110;
                else begin
                    disc_next = 0;
                    flag_next = 1;
                    err_next = 0;
                end
            end
            3'b110: begin
                if (in) begin
                    disc_next = 1;
                    flag_next = 0;
                    err_next = 0;
                end
                else begin
                    disc_next = 0;
                    flag_next = 0;
                    err_next = 1;
                end
            end
            3'b111: begin
                if (in) begin
                    disc_next = 0;
                    flag_next = 0;
                    err_next = 1;
                end
                else
                    state <= 3'b000;
            end
        endcase
    end

    always @(posedge clk) begin
        disc <= disc_next;
        flag <= flag_next;
        err <= err_next;
    end
endmodule
