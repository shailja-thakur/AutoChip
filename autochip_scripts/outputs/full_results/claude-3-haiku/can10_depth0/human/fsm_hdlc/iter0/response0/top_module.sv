module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam INITIAL = 2'b00;
localparam DISCARD = 2'b01;
localparam FLAG = 2'b10;
localparam ERROR = 2'b11;

reg [1:0] state, next_state;
reg [2:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= INITIAL;
        count <= 0;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            INITIAL: begin
                if (in == 1) begin
                    count <= 1;
                end
                else begin
                    count <= 0;
                end
            end
            DISCARD: begin
                if (in == 1) begin
                    count <= count + 1;
                    if (count == 5) begin
                        count <= 0;
                    end
                end
                else begin
                    count <= 0;
                end
            end
            FLAG: begin
                if (in == 1) begin
                    count <= count + 1;
                    if (count == 7) begin
                        count <= 0;
                        err <= 1;
                    end
                end
                else begin
                    count <= 0;
                    flag <= 1;
                end
            end
            ERROR: begin
                if (in == 1) begin
                    count <= count + 1;
                    if (count == 7) begin
                        count <= 0;
                    end
                end
                else begin
                    count <= 0;
                    err <= 0;
                end
            end
        endcase
    end
end

always @(*) begin
    case (state)
        INITIAL: begin
            if (in == 1) begin
                next_state = DISCARD;
            end
            else begin
                next_state = INITIAL;
            end
            disc = 0;
            flag = 0;
            err = 0;
        end
        DISCARD: begin
            if (in == 1 && count == 5) begin
                next_state = FLAG;
            end
            else if (in == 0) begin
                next_state = INITIAL;
            end
            else begin
                next_state = DISCARD;
            end
            disc = 1;
            flag = 0;
            err = 0;
        end
        FLAG: begin
            if (in == 1 && count == 6) begin
                next_state = FLAG;
            end
            else if (in == 0) begin
                next_state = INITIAL;
            end
            else if (in == 1 && count == 7) begin
                next_state = ERROR;
            end
            else begin
                next_state = FLAG;
            end
            disc = 0;
            flag = 1;
            err = 0;
        end
        ERROR: begin
            if (in == 1 && count == 7) begin
                next_state = ERROR;
            end
            else if (in == 0) begin
                next_state = INITIAL;
            end
            else begin
                next_state = ERROR;
            end
            disc = 0;
            flag = 0;
            err = 1;
        end
    endcase
end

endmodule
