module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

logic [1:0] counter;

always_ff @(posedge clk, posedge areset) begin
    if(areset) begin
        counter <= 2'b01;
    end
    else begin
        if(train_valid) begin
            if(train_taken) begin
                if(counter < 3) begin
                    counter <= counter + 1;
                end
            end
            else begin
                if(counter > 0) begin
                    counter <= counter - 1;
                end
            end
        end
    end
end

assign state = counter;

endmodule
